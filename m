Received: from eggs.gnu.org ([2001:4830:134:3::10]:51088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVaiO-0000Zf-Oy
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 05:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVaiN-000271-W2
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 05:47:20 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:35847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dVaiN-00026d-Q8
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 05:47:19 -0400
Received: by mail-wm0-x236.google.com with SMTP id 62so18066937wmw.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 02:47:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170711083552.17433-1-stefanha@redhat.com>
References: <20170711083552.17433-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2017 10:46:58 +0100
Message-ID: <CAFEAcA9+W8ad0Nu3OufXdKXBYaf1E6NFApB-nZrsMqbgAzWnXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] Tracing patches
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

On 11 July 2017 at 09:35, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit 6b06e3e49eb8c91cc286c16d6bf3181ac296f3=
3d:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2017-07-10-v2=
' into staging (2017-07-10 16:12:47 +0100)
>
> are available in the git repository at:
>
>   git://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to cbea0ac4fe4989ae70088e01ad8b5e99f7ce3846:
>
>   backends: remove empty trace-events file (2017-07-11 09:35:11 +0100)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Daniel P. Berrange (1):
>   backends: remove empty trace-events file
>
> Llu=C3=ADs Vilanova (1):
>   trace: Fix early setting of events with the "vcpu" property
>

Applied, thanks.

-- PMM
