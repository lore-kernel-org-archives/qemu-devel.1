Received: from eggs.gnu.org ([2001:4830:134:3::10]:48916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coD8I-0001Ox-I9
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 13:54:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coD8H-0002vj-PB
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 13:54:46 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1coD8H-0002vO-Id
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 13:54:45 -0400
Received: by mail-wm0-x235.google.com with SMTP id n11so29310635wma.0
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 10:54:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170315050602.7750-1-stefanha@redhat.com>
References: <20170315050602.7750-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Mar 2017 17:54:23 +0000
Message-ID: <CAFEAcA_Vt2rUbHaL=U1nJE47q2LtbCTYggFVCiJ3bGkM=tiMOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL for-2.9 0/1] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 15 March 2017 at 05:06, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit d84f714eafedd8bb9d4aaec8b76417bef8e3535e:
>
>   Update version for v2.9.0-rc0 release (2017-03-14 19:18:23 +0000)
>
> are available in the git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 9dc44aa5829eb3131a01378a738dee28a382bbc1:
>
>   os: don't corrupt pre-existing memory-backend data with prealloc (2017-03-15 11:55:41 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Daniel P. Berrange (1):
>   os: don't corrupt pre-existing memory-backend data with prealloc
>
>  util/oslib-posix.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

Applied, thanks.

-- PMM
