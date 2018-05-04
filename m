Received: from eggs.gnu.org ([2001:4830:134:3::10]:51641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fEeJ9-0005bj-19
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fEeJ7-0000Wb-RX
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52470 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fEeJ7-0000VC-MP
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:45 -0400
References: <20171108022828.7242-1-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <23253f77-ccc8-220d-3028-f27945f9542c@redhat.com>
Date: Fri, 4 May 2018 19:15:37 +0200
MIME-Version: 1.0
In-Reply-To: <20171108022828.7242-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/6] generic way to deprecate machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org

On 08.11.2017 03:28, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi,
>=20
> This series intends to provide a simple and common way to deprecate
> machines between releases. It may be extended to deprecate devices.

*ping*

Philippe, I just discovered your findings wrt to the Gumstix machines on
https://wiki.qemu.org/Features/LegacyRemoval#Deprecated_machines ...
sounds reasonable, so I think we should really continue here and mark
those as deprecated. And pc-0.10 and pc-0.11, too.

Do you have some spare time to respin your patch series?

 Thomas
