Received: from eggs.gnu.org ([2001:4830:134:3::10]:47285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH3i3-0001fR-S0
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 05:19:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH3i0-0007h5-Nv
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 05:19:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gH3i0-0007fV-Hm
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 05:19:40 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A76E230D27
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 09:19:37 +0000 (UTC)
Date: Mon, 29 Oct 2018 10:19:30 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181029091930.knhlkhy3ipf5bks3@sirius.home.kraxel.org>
References: <20181025085256.20522-1-kraxel@redhat.com>
	<20181025085256.20522-2-kraxel@redhat.com>
	<34baf361-0f1a-cdb2-9b2e-bef68dbfd154@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <34baf361-0f1a-cdb2-9b2e-bef68dbfd154@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] qdev: add deprecation_reason to
 DeviceClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Prasad J Pandit <ppandit@redhat.com>

On Thu, Oct 25, 2018 at 01:12:15PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Hi Gerd,
>=20
> On 25/10/18 10:52, Gerd Hoffmann wrote:
> > Simliar to deprecated machine types.
>=20
> "Similar"
>=20
> > Print a warning when creating a deprecated device.
> > Add deprecation notice to -device help.
> >=20
> > TODO: add to intospection.
>=20
> "introspection"
>=20
> Do we want the TODO in the git history?

No.  It's RfC because of the missing introspection bits ;)

cheers,
  Gerd
