Received: from eggs.gnu.org ([2001:4830:134:3::10]:47945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnnps-0004wa-Qc
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnnpq-0004OP-F7
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:26:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dnnpq-0004OB-8f
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:26:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 485B4267F5
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 15:26:17 +0000 (UTC)
Date: Fri, 1 Sep 2017 23:26:10 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170901152610.GA5845@lemon.lan>
References: <20170901105023.11108-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170901105023.11108-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] pixman: drop submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, 09/01 12:50, Gerd Hoffmann wrote:
> Drop pixman submodule and support for the "internal" pixman build.
> pixman should be reasonable well established meanwhile that we don't
> need the fallback submodule any more.  While being at it also drop
> some #ifdefs for pixman versions olter than what we require in

s/olter/older/ ?

> configure anyway.

Fam
