Received: from eggs.gnu.org ([209.51.188.92]:54915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmyCI-0002y0-QF
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 04:54:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmyCG-00026g-Vc
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 04:54:50 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:40355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmyCF-00024B-36
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 04:54:48 -0500
Received: by mail-ot1-x331.google.com with SMTP id s5so7983360oth.7
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 01:54:45 -0800 (PST)
MIME-Version: 1.0
References: <20190124122614.16624-1-berrange@redhat.com>
In-Reply-To: <20190124122614.16624-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Jan 2019 09:54:33 +0000
Message-ID: <CAFEAcA8pqWZrJPy8ru8XXu7U6tHyVW66bcn-xYHrOVE+TawDgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/1] Qio next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 24 Jan 2019 at 12:26, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The following changes since commit 6d809e7da943bb4b95b408fbf3d80d097c0f7d=
38:
>
>   Merge remote-tracking branch 'remotes/xtensa/tags/20190122-xtensa' into=
 staging (2019-01-23 21:50:49 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/berrange/qemu tags/qio-next-pull-request
>
> for you to fetch changes up to 73564c407caedf992a1c688b5fea776a8b56ba2a:
>
>   io: ensure UNIX client doesn't unlink server socket (2019-01-24 12:23:3=
5 +0000)
>
> ----------------------------------------------------------------
> Merge qio 2019/01/24
>
> Fixes accidental deletion of VNC server UNIX listener socket
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
