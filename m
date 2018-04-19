Received: from eggs.gnu.org ([2001:4830:134:3::10]:51947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6403088e3=Ian.Jackson@citrix.com>)
	id 1f9CUa-0002TP-O2
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6403088e3=Ian.Jackson@citrix.com>)
	id 1f9CUV-0001SO-SA
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:33:04 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:52348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=6403088e3=Ian.Jackson@citrix.com>)
	id 1f9CUV-0001PL-K1
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:32:59 -0400
From: Ian Jackson <ian.jackson@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23256.50356.85322.950961@mariner.uk.xensource.com>
Date: Thu, 19 Apr 2018 17:32:52 +0100
In-Reply-To: <23224.64658.859133.831793@mariner.uk.xensource.com>
References: <1520535787-6223-1-git-send-email-ian.jackson@eu.citrix.com>
	<1520535787-6223-2-git-send-email-ian.jackson@eu.citrix.com>
	<e2f1cee4-8dad-d901-ae2f-51495a855b4e@redhat.com>
	<23224.64658.859133.831793@mariner.uk.xensource.com>
Subject: Re: [Qemu-devel] [PATCH 01/12] checkpatch: Add
 xendevicemodel_handle to the list of types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano
	Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Eric  Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Ian Jackson writes ("Re: [PATCH 01/12] checkpatch: Add xendevicemodel_handle to the list of types"):
> Paolo Bonzini writes ("Re: [PATCH 01/12] checkpatch: Add xendevicemodel_handle to the list of types"):
> > Or just rename it so that it is CamelCase.  Then checkpatch will be happy.
> 
> I can do that if you want,

No I can't, because it's from the Xen headers, not a qemu type.

I have added a note to the commit message for the checkpatch commit.

Ian.
