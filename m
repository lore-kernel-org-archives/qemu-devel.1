Received: from eggs.gnu.org ([2001:4830:134:3::10]:42554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ebk21-0006Eb-Uh
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 04:29:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ebk21-0006FX-1t
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 04:29:17 -0500
Date: Wed, 17 Jan 2018 10:28:37 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180117092837.k7uvhdb44eao7nj6@eukaryote>
References: <20171226025247.11082-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171226025247.11082-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 0/2] qemu-img: Document --force-share /
 -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, stefanha@redhat.com, Kevin Wolf <kwolf@redhat.com>, eblake@redhat.com, Max Reitz <mreitz@redhat.com>

On Tue, Dec 26, 2017 at 10:52:45AM +0800, Fam Zheng wrote:
> v5: Clean up the @table @var section first. [Kevin, Peter]
> 
> Fam Zheng (2):
>   qemu-img.texi: Clean up parameter list
>   qemu-img: Document --force-share / -U

Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>

This documentation patch should really be merged, as the '--force-share'
was not at all documented when it was released in QEMU 2.10.

> 2.14.3
> 

-- 
/kashyap
