Received: from eggs.gnu.org ([2001:4830:134:3::10]:58013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=644fc49e2=anthony.perard@citrix.com>)
	id 1fAdXz-0005bt-F8
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:38:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=644fc49e2=anthony.perard@citrix.com>)
	id 1fAdXw-0001dV-9C
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:38:31 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:28355)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=644fc49e2=anthony.perard@citrix.com>)
	id 1fAdXw-0001cv-03
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:38:28 -0400
Date: Mon, 23 Apr 2018 16:38:12 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180423153812.GD1980@perard>
References: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524156319-11465-13-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1524156319-11465-13-git-send-email-ian.jackson@eu.citrix.com>
Subject: Re: [Qemu-devel] [PATCH 12/16] xen: Remove now-obsolete
 xen_xc_domain_add_to_physmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>
Cc: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

On Thu, Apr 19, 2018 at 05:45:15PM +0100, Ian Jackson wrote:
> The last user was just removed; remove this function, accordingly.
> 
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
