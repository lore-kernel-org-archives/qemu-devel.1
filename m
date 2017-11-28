Received: from eggs.gnu.org ([2001:4830:134:3::10]:45699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eJkbc-0003x4-1I
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 13:27:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eJkbX-0000ZP-UC
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 13:27:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eJkbX-0000Z5-LN
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 13:27:35 -0500
Date: Tue, 28 Nov 2017 16:27:27 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171128182727.GO3037@localhost.localdomain>
References: <20171128161529.3025-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171128161529.3025-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] qemu-options: document missing memory
 backend items
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Hu Tao <hutao@cn.fujitsu.com>

On Tue, Nov 28, 2017 at 04:15:27PM +0000, Stefan Hajnoczi wrote:
> This series adds several missing items to the QEMU documentation on memory
> backends.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

I'm queueing it for 2.12 on machine-next.  Thanks.

-- 
Eduardo
