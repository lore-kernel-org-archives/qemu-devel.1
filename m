Received: from eggs.gnu.org ([209.51.188.92]:43076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hFzIJ-0006s7-Hj
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:57:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hFzII-0008Vz-PQ
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:56:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hFzII-0008VQ-Eo
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:56:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4D1E459454
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 10:56:57 +0000 (UTC)
References: <20190411175345.19414-1-thuth@redhat.com>
	<20190412183628.GA31999@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <092afc3f-68fc-7a08-a9a4-e1b9f5a482ec@redhat.com>
Date: Mon, 15 Apr 2019 12:56:48 +0200
MIME-Version: 1.0
In-Reply-To: <20190412183628.GA31999@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1] Declare -realtime as
 deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, libvir-list@redhat.com

On 12/04/19 20:36, Eduardo Habkost wrote:
>> let's deprecate the old -realtime option.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> Paolo, do you want to queue this, or should I do it through the
> machine queue?
> 
> -- Eduardo

I have just queued it.

Paolo
