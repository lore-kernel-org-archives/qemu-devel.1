Received: from eggs.gnu.org ([209.51.188.92]:42237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hC3PA-0004rv-OC
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 10:31:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hC3Dl-0002JN-QL
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 10:20:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hC3Dl-0002Ia-Ic
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 10:20:01 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CBBF83168AAE
	for <qemu-devel@nongnu.org>; Thu,  4 Apr 2019 14:20:00 +0000 (UTC)
Date: Thu, 4 Apr 2019 16:19:49 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190404161949.3d6da7cb@redhat.com>
In-Reply-To: <858fe186-63af-48af-2569-af1aa2d09f6f@redhat.com>
References: <20190402161900.7374-1-armbru@redhat.com>
	<20190402161900.7374-4-armbru@redhat.com>
	<20190404121433.47ed0f4f@redhat.com>
	<858fe186-63af-48af-2569-af1aa2d09f6f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] acpi/pcihp: Add a few more trace
 points related to unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com

On Thu, 4 Apr 2019 14:54:51 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> Hi Igor,
> 
> On 04/04/19 12:14, Igor Mammedov wrote:
> > On Tue,  2 Apr 2019 18:19:00 +0200
> > Markus Armbruster <armbru@redhat.com> wrote:
> >   
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>  
> > 
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>  
> 
> did you mean: "R-b: Igor" instead?
:) yep, copied name from wrong field which is easy feat in claws-mail

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> Laszlo
