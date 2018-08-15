Received: from eggs.gnu.org ([2001:4830:134:3::10]:60974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fptOm-0002ca-M8
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 06:51:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fptOl-0001zn-MM
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 06:51:32 -0400
Date: Wed, 15 Aug 2018 12:51:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180815105113.GE4411@localhost.localdomain>
References: <be0db6859accf4df30f594b7bd52f1f0500e977b.1534328682.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be0db6859accf4df30f594b7bd52f1f0500e977b.1534328682.git.pkrempa@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qapi: block: Remove mentions
 of error types which were removed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org

Am 15.08.2018 um 12:26 hat Peter Krempa geschrieben:
> Most of the various error classes were removed prior to the 1.2 release.
> Remove mentions of the error classes which did not make it.
> 
> Signed-off-by: Peter Krempa <pkrempa@redhat.com>

Thanks, applied to the block branch.

Kevin
