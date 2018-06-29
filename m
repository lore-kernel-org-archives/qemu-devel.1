Received: from eggs.gnu.org ([2001:4830:134:3::10]:51335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYvlT-0000Fg-PC
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:56:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYvlS-0004FW-UE
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:56:51 -0400
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:43918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYvlS-0004Ef-Ox
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:56:50 -0400
Received: by mail-oi0-x230.google.com with SMTP id 8-v6so4260645oin.10
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 08:56:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629112520.31358-1-berrange@redhat.com>
References: <20180629112520.31358-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 16:56:29 +0100
Message-ID: <CAFEAcA-mgwQpk4iAiO12LbD9XKX0pcnZb5vaF=h4Aq674Uprvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/3] Min glib patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Olaf Hering <olaf@aepfle.de>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>

On 29 June 2018 at 12:25, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wro=
te:
> The following changes since commit 609ef9f451759151d0bfe7c3843410ab94d68f=
18:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/qio-next-pull-reque=
st' into staging (2018-06-28 17:53:31 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/berrange/qemu tags/min-glib-pull-request
>
> for you to fetch changes up to e71e8cc035558eabd6b3e19f6d3254c754c027ef:
>
>   glib: enforce the minimum required version and warn about old APIs (201=
8-06-29 12:22:28 +0100)
>
> ----------------------------------------------------------------
> glib: update the min required version
>
> This updates the minimum required glib version to 2.40
>
> ----------------------------------------------------------------
Applied, thanks.

-- PMM
