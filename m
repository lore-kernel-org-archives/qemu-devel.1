Received: from eggs.gnu.org ([2001:4830:134:3::10]:48071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXlaW-0004Wt-Fo
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXlaV-0001lN-QX
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:48:12 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dXlaV-0001kn-Ho
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:48:11 -0400
Received: by mail-wm0-x235.google.com with SMTP id g127so10249087wmd.0
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 02:48:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170718103251.20657-1-berrange@redhat.com>
References: <20170718103251.20657-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Jul 2017 10:47:48 +0100
Message-ID: <CAFEAcA-qCJQcP4hCEHisVOmqj3t4agE9opLV_dUXBXJi4E6-zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 0/1] Merge I/O 2017/07/18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 18 July 2017 at 11:32, Daniel P. Berrange <berrange@redhat.com> wrote:
> The following changes since commit 9964e96dc9999cf7f7c936ee854a795415d19b60:
>
>   Merge remote-tracking branch 'jasowang/tags/net-pull-request' into staging (2017-05-23 15:01:31 +0100)
>
> are available in the git repository at:
>
>   git://github.com/berrange/qemu tags/pull-qio-2017-07-18-1
>
> for you to fetch changes up to 8f7168b34323ceec4d5faff797e7bcf1be57e6be:
>
>   io: simplify qio_channel_attach_aio_context (2017-05-26 10:38:08 +0100)
>
> ----------------------------------------------------------------
> Merge I/O 2017/07/18 v1
>
> ----------------------------------------------------------------
> Paolo Bonzini (1):
>   io: simplify qio_channel_attach_aio_context
>
>  io/channel.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

Applied, thanks.

-- PMM
