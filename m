Received: from eggs.gnu.org ([2001:4830:134:3::10]:54614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e02A3-0002BB-4s
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 05:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e02A2-0001bc-9q
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 05:09:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e02A2-0001a7-3M
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 05:09:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 490A7882FB
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 09:09:41 +0000 (UTC)
Date: Thu, 5 Oct 2017 10:09:37 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171005090937.GA4300@work-vm>
References: <20171002134538.23332-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171002134538.23332-1-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] hmp-commands-info: Texinfo fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

* Markus Armbruster (armbru@redhat.com) wrote:
> Markus Armbruster (3):
>   hmp-commands-info: Fix "info rocker-FOO" misspellings
>   hmp-commands-info: Move Texinfo stanzas to conventional place
>   hmp-commands-info: Change "@findex FOO" to "@findex info FOO"

Queued for HMP

>  hmp-commands-info.hx | 138 +++++++++++++++++++++++++--------------------------
>  1 file changed, 69 insertions(+), 69 deletions(-)
> 
> -- 
> 2.13.6
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
