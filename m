Received: from eggs.gnu.org ([2001:4830:134:3::10]:51234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejOVa-0002ui-PY
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:07:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejOVX-0005Ac-6v
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:07:26 -0500
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:35633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ejOVW-00059q-VG
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:07:23 -0500
Received: by mail-ot0-x22b.google.com with SMTP id a2so576808otf.2
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 04:07:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180205230900.11344-1-ehabkost@redhat.com>
References: <20180205230900.11344-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Feb 2018 12:07:02 +0000
Message-ID: <CAFEAcA_MsgdkO2JWrukJ36Bn-645oJJvTn7pQ2LKnTR6BCaG=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/21] Python queue, 2018-02-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>

On 5 February 2018 at 23:08, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit f24ee107a07f093bd7ed475dd48d7ba57ea3d8fe:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180202-pull-request' into staging (2018-02-02 18:54:11 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to 356dc290f0ef930a24b6af3a0908b1cb58ad47c9:
>
>   docker: change Fedora images to run with python3 (2018-02-05 19:53:55 -0200)
>
> ----------------------------------------------------------------
> Python queue, 2018-02-05
>
> ----------------------------------------------------------------

Applied, thanks. (I've also updated one of my local build configs
to use --with-python=python3; thanks to Daniel Berrange for the suggestion.)

-- PMM
