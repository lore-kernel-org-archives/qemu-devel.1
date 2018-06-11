Received: from eggs.gnu.org ([2001:4830:134:3::10]:46385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fSTxD-0001xL-MB
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:02:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fSTxA-0006Gl-Jz
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:02:19 -0400
Received: from mail-eopbgr690064.outbound.protection.outlook.com
	([40.107.69.64]:55760
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fSTxA-0006GF-5U
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:02:16 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Mon, 11 Jun 2018 21:02:13 +0000
Message-ID: <DM5PR12MB24717E71CD556E950C4FBFED95780@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <1528498581-131037-1-git-send-email-babu.moger@amd.com>
	<1528498581-131037-2-git-send-email-babu.moger@amd.com>
	<20180611205433.GY7451@localhost.localdomain>
In-Reply-To: <20180611205433.GY7451@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v13 1/5] i386: Add support for
 CPUID_8000_001E for AMD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kash@tripleback.net" <kash@tripleback.net>, "geoff@hostfission.com" <geoff@hostfission.com>


> -----Original Message-----
> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> Sent: Monday, June 11, 2018 3:55 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: mst@redhat.com; marcel.apfelbaum@gmail.com; pbonzini@redhat.com;
> rth@twiddle.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> kvm@vger.kernel.org; kash@tripleback.net; geoff@hostfission.com
> Subject: Re: [PATCH v13 1/5] i386: Add support for CPUID_8000_001E for
> AMD
>=20
> On Fri, Jun 08, 2018 at 06:56:17PM -0400, Babu Moger wrote:
> > Add support for cpuid leaf CPUID_8000_001E. Build the config that close=
ly
> > match the underlying hardware. Please refer to the Processor
> Programming
> > Reference (PPR) for AMD Family 17h Model for more details.
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
>=20
> Queued on x86-next, thanks.
>=20

Thanks

> --
> Eduardo
