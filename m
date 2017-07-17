Received: from eggs.gnu.org ([2001:4830:134:3::10]:56996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXAjt-0001Gu-C3
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXAjs-0000wd-LU
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:27:25 -0400
References: <20170714183224.7209-1-eblake@redhat.com>
	<20170714183224.7209-2-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <71f74f61-6b8d-06a8-e962-e6cfbbb59ec5@redhat.com>
Date: Mon, 17 Jul 2017 14:27:18 -0400
MIME-Version: 1.0
In-Reply-To: <20170714183224.7209-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] nbd: Trace client command
 being sent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org



On 07/14/2017 02:32 PM, Eric Blake wrote:
> Make the client trace slightly more legible by including the name
> of the command being sent.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>
