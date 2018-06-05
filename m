Received: from eggs.gnu.org ([2001:4830:134:3::10]:60407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQGRw-000242-NI
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 14:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQGRt-0003BU-Go
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 14:12:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fQGRt-0003Ai-Ab
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 14:12:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9485130041E6
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 18:12:48 +0000 (UTC)
Date: Tue, 5 Jun 2018 15:12:46 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180605181246.GN7451@localhost.localdomain>
References: <1528207243-268226-1-git-send-email-imammedo@redhat.com>
	<1528207243-268226-2-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528207243-268226-2-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] cli: Don't run early event loop if
 no --preconfig was specified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, ldoktor@redhat.com

On Tue, Jun 05, 2018 at 04:00:42PM +0200, Igor Mammedov wrote:
[...]
> Based on
>   From: Michal Privoznik <mprivozn@redhat.com>
>   Subject: [PATCH] cli: Don't run early event loop if no --preconfig was specified
>   Message-Id: <ad910973c593c5ac2fed3a10ea958f7e9c12f82c.1527935663.git.mprivozn@redhat.com>

Michal's patch is already queued on machine-next.  It should be
dropped if this patch gets included, correct?

-- 
Eduardo
