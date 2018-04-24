Received: from eggs.gnu.org ([2001:4830:134:3::10]:40962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6454bde7c=Ian.Jackson@citrix.com>)
	id 1fAzYy-0000n1-IB
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:09:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6454bde7c=Ian.Jackson@citrix.com>)
	id 1fAzYu-0004ZR-Er
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:09:00 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:57697)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=6454bde7c=Ian.Jackson@citrix.com>)
	id 1fAzYu-0004Pq-50
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:08:56 -0400
From: Ian Jackson <ian.jackson@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23263.18564.94252.535366@mariner.uk.xensource.com>
Date: Tue, 24 Apr 2018 16:08:52 +0100
In-Reply-To: <20180423155816.GF1980@perard>
References: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524156319-11465-6-git-send-email-ian.jackson@eu.citrix.com>
	<20180423155816.GF1980@perard>
Subject: Re: [Qemu-devel] [PATCH 05/16] xen: defer call to xen_restrict
 until just before os_setup_post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Anthony PERARD writes ("Re: [PATCH 05/16] xen: defer call to xen_restrict until just before os_setup_post"):
> I think this include is not needed anymore, and can go away from the
> patch series.

Yes.

Thanks,
Ian.
