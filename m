Received: from eggs.gnu.org ([2001:4830:134:3::10]:48682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1g7mOQ-0004zH-FF
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 15:01:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1g7mOM-0001Lm-9u
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 15:01:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1g7mOM-0001KM-2J
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 15:01:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1AED05D66B
	for <qemu-devel@nongnu.org>; Wed,  3 Oct 2018 19:00:59 +0000 (UTC)
Date: Wed, 3 Oct 2018 16:00:57 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181003190057.GG5738@habkost.net>
References: <20181003104605.8477-1-kchamart@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003104605.8477-1-kchamart@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qapi/misc.json: Remove superfluous words
 in CpuModelExpansionType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com

On Wed, Oct 03, 2018 at 12:46:05PM +0200, Kashyap Chamarthy wrote:
> While at it, s/QMU/QEMU in @CpuDefinitionInfo.
> 
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Will this go through the QAPI tree?

-- 
Eduardo
