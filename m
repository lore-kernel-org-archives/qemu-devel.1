Received: from eggs.gnu.org ([2001:4830:134:3::10]:59935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=442a0b037=Ian.Jackson@citrix.com>)
	id 1dzQwg-00035x-I6
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 13:25:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=442a0b037=Ian.Jackson@citrix.com>)
	id 1dzQwc-0007fV-Kx
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 13:25:26 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:21532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=442a0b037=Ian.Jackson@citrix.com>)
	id 1dzQwc-0007f8-99
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 13:25:22 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <22995.51199.956478.271814@mariner.uk.xensource.com>
Date: Tue, 3 Oct 2017 18:25:19 +0100
In-Reply-To: <20170925150148.GG1859@perard.uk.xensource.com>
References: <1505498999-17427-1-git-send-email-ian.jackson@eu.citrix.com>
	<1505498999-17427-2-git-send-email-ian.jackson@eu.citrix.com>
	<20170925150148.GG1859@perard.uk.xensource.com>
Subject: Re: [Qemu-devel] [PATCH RFC 1/6] xen: link against xentoolcore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, Juergen Gross <jgross@suse.com>, Stefano
	Stabellini <sstabellini@kernel.org>, xen-devel@nongnu.org

Anthony PERARD writes ("Re: [Qemu-devel] [PATCH RFC 1/6] xen: link against xentoolcore"):
> Here is a patch that I think will work, if libxentoolcore is release in
> Xen 4.10.

Thanks very much.  I have, more or less, adopted this.  Thanks also
for your other comments, which I have addressed.

Ian.
