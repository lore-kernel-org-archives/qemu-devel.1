Received: from eggs.gnu.org ([2001:4830:134:3::10]:47278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1emGNs-0001Nt-U4
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:03:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1emGNp-0006DT-78
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:03:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48712 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1emGNp-00066o-2l
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:03:17 -0500
Date: Thu, 15 Feb 2018 11:02:54 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180215100254.bxrruhc4utmowmmc@sirius.home.kraxel.org>
References: <20180215042900.16078-1-f4bug@amsat.org>
	<20180215042900.16078-23-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180215042900.16078-23-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 22/30] hw/display: use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>

On Thu, Feb 15, 2018 at 01:28:52AM -0300, Philippe Mathieu-Daud=E9 wrote:
> It ease code review, unit is explicit.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
