Received: from eggs.gnu.org ([2001:4830:134:3::10]:41312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ePuq1-0003Ud-Jr
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:36:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ePuq0-0006lU-QB
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:36:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1ePuq0-0006iQ-Jd
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:36:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14B71368E6
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 18:35:59 +0000 (UTC)
Date: Fri, 15 Dec 2017 19:35:54 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20171215183554.hra43ak4sc2yjtgw@eukaryote>
References: <20171215154507.20299-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171215154507.20299-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] docs: Convert migration.txt to rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, berrange@redhat.com, peterx@redhat.com

On Fri, Dec 15, 2017 at 03:45:07PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Mostly just manual conversion with very minor fixes.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
> 
> v2
>   Fixed issues found by Peter and Kashyap.
>   Remove the detailed QEMUFile explanation and point to the header
>   and QIOChannel code [after discussion with Daniel on Jay Zhou's patch]
> 
>  docs/devel/{migration.txt => migration.rst} | 476 +++++++++++++++-------------
>  1 file changed, 250 insertions(+), 226 deletions(-)
>  rename docs/devel/{migration.txt => migration.rst} (58%)

Looks much better.

Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>

[...]

-- 
/kashyap
