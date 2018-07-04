Received: from eggs.gnu.org ([2001:4830:134:3::10]:51910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fabGt-0000a9-JR
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 02:28:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fabGs-000189-OM
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 02:28:11 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:45373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fabGs-00017y-IN
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 02:28:10 -0400
Received: by mail-oi0-x233.google.com with SMTP id m2-v6so8614136oim.12
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 23:28:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180703120512.31648-1-berrange@redhat.com>
References: <20180703120512.31648-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Jul 2018 07:27:49 +0100
Message-ID: <CAFEAcA_Y30kwV+bM_Ep5tAFB=dNkQ6MTOG5U9zt6xxQFMwDZAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/1] Qcrypto next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Jones <rjones@redhat.com>

On 3 July 2018 at 13:05, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrot=
e:
> The following changes since commit 9b75dcb15f562577a937ae01f324946513586e=
59:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-07-02' i=
nto staging (2018-07-03 10:47:02 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/berrange/qemu tags/qcrypto-next-pull-request
>
> for you to fetch changes up to e1a6dc91ddb55ef77a705b62b6e62634631fd57d:
>
>   crypto: Implement TLS Pre-Shared Keys (PSK). (2018-07-03 13:04:38 +0100=
)
>
> ----------------------------------------------------------------
> Add support for PSK credentials with TLS
>
> ----------------------------------------------------------------
>
> Richard W.M. Jones (1):
>   crypto: Implement TLS Pre-Shared Keys (PSK).

Applied, thanks.

-- PMM
