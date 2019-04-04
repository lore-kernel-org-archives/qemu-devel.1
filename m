Received: from eggs.gnu.org ([209.51.188.92]:43973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hC1tU-0005xD-Tb
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 08:55:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hC1tU-0001d5-2A
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 08:55:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hC1tT-0001aG-Q0
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 08:54:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 567B8316E935
	for <qemu-devel@nongnu.org>; Thu,  4 Apr 2019 12:54:58 +0000 (UTC)
References: <20190402161900.7374-1-armbru@redhat.com>
	<20190402161900.7374-4-armbru@redhat.com>
	<20190404121433.47ed0f4f@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <858fe186-63af-48af-2569-af1aa2d09f6f@redhat.com>
Date: Thu, 4 Apr 2019 14:54:51 +0200
MIME-Version: 1.0
In-Reply-To: <20190404121433.47ed0f4f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com

Hi Igor,

On 04/04/19 12:14, Igor Mammedov wrote:
> On Tue,  2 Apr 2019 18:19:00 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

did you mean: "R-b: Igor" instead?

Laszlo
