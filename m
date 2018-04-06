Received: from eggs.gnu.org ([2001:4830:134:3::10]:44806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f4Vri-000808-5b
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:13:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f4Vrh-0002nb-8A
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:13:34 -0400
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:43259)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f4Vrh-0002mN-2R
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:13:33 -0400
Received: by mail-ot0-x22f.google.com with SMTP id m22-v6so2118436otf.10
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 11:13:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180406133046.5682-1-berrange@redhat.com>
References: <20180406133046.5682-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Apr 2018 19:13:12 +0100
Message-ID: <CAFEAcA-jwz4T_QKX56su-fodKFpv1ptE3m7-9ma+pN_op=k2bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL for-2.12 0/3] Qcrypto next patches
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

On 6 April 2018 at 14:30, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wro=
te:
> The following changes since commit 0e87fdc966d05f4e5ad868034fcd8ee2a08ca6=
2d:
>
>   Update version for v2.12.0-rc2 release (2018-04-04 20:37:20 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/berrange/qemu tags/qcrypto-next-pull-request
>
> for you to fetch changes up to 057ad0b46992e3ec4ce29b9103162aa3c683f347:
>
>   crypto: ensure we use a predictable TLS priority setting (2018-04-06 11=
:28:31 +0100)
>
> ----------------------------------------------------------------
>
> Two improvements to TLS docs, and a fix for the test suite to
> avoid breakage on Fedora >=3D 28
>

Applied, thanks.

-- PMM
