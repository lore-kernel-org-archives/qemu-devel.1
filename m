Received: from eggs.gnu.org ([2001:4830:134:3::10]:35720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN7pq-00035M-3C
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 21:56:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN7pp-0004sq-AM
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 21:56:50 -0500
References: <20181005234023.8104-1-mreitz@redhat.com>
	<20181005234023.8104-8-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ca7b9412-aa4d-4939-1b2b-4db4aed5c9f4@redhat.com>
Date: Wed, 14 Nov 2018 20:56:27 -0600
MIME-Version: 1.0
In-Reply-To: <20181005234023.8104-8-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 07/31] iotests.py: Add node_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org

On 10/5/18 6:39 PM, Max Reitz wrote:
> This function queries a node; since we cannot do that right now, it
> executes query-named-block-nodes and returns the matching node's object.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/iotests.py | 7 +++++++
>   1 file changed, 7 insertions(+)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
