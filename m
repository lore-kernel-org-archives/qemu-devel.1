Received: from eggs.gnu.org ([2001:4830:134:3::10]:38112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZzTI-0003vp-Ak
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:34:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZzTD-00049j-AT
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:34:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eZzTD-000489-4q
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:34:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3574870D7D
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 13:34:06 +0000 (UTC)
Date: Fri, 12 Jan 2018 14:34:03 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180112133403.kypz4zkeubaqgb4n@sirius.home.kraxel.org>
References: <20171212113440.16483-1-berrange@redhat.com>
	<20180110164303.GQ3205@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180110164303.GQ3205@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ui: deprecate use of GTK 2.x in favour of
 3.x series
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Jan 10, 2018 at 04:43:03PM +0000, Daniel P. Berrange wrote:
> ping.
> 
> Gerd, do you have any opinions on this, and also deprecating SDL-1 ?

Patch added to queue.

Yes, I'll take a SDL-1 deprecation patch too.

cheers,
  Gerd
