Received: from eggs.gnu.org ([2001:4830:134:3::10]:45356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXk79-0001iW-U3
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:50:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXk78-0008Bs-Vc
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:50:35 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:34948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXk78-0008BT-Nl
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:50:34 -0500
Received: by mail-oi1-x22f.google.com with SMTP id v6so4092133oif.2
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 01:50:34 -0800 (PST)
MIME-Version: 1.0
References: <20181212112450.2103-1-berrange@redhat.com>
In-Reply-To: <20181212112450.2103-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 09:50:23 +0000
Message-ID: <CAFEAcA-M72owjhqbgG6G-fsaTThEMD2uUnpwXbMVnhGP4x3K0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/6] Qcrypto next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>

On Wed, 12 Dec 2018 at 11:24, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The following changes since commit bb9bf94b3e8926553290bc9a7cb84315af4220=
86:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-r=
equest' into staging (2018-12-11 19:18:58 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/berrange/qemu tags/qcrypto-next-pull-request
>
> for you to fetch changes up to c972fa123c73501b4b0c6de7873754ea3205a5eb:
>
>   crypto: support multiple threads accessing one QCryptoBlock (2018-12-12=
 11:16:49 +0000)
>
> ----------------------------------------------------------------
> Merge crypto patches 2018/12/12
>
>  - Fix documentation about default LUKS algorithms
>  - Support for multi-threaded block crypto
>
> ----------------------------------------------------------------
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
