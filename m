Received: from eggs.gnu.org ([2001:4830:134:3::10]:49811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fa6c0-0005Er-UG
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 17:43:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fa6bx-0002ac-Kn
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 17:43:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fa6bx-0002aF-Em
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 17:43:53 -0400
Date: Mon, 2 Jul 2018 18:43:45 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180702214345.GI7451@localhost.localdomain>
References: <20180702094152.7882-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702094152.7882-1-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1] machine: properly free device_memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On Mon, Jul 02, 2018 at 11:41:52AM +0200, David Hildenbrand wrote:
> Machines might have inititalized device_memory if they support memory
> devices, so let's properly free it.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Queued, thanks.

-- 
Eduardo
