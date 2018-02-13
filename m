Received: from eggs.gnu.org ([2001:4830:134:3::10]:48259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elZeg-0006zM-3m
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:25:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elZef-0005tL-A7
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:25:50 -0500
Date: Tue, 13 Feb 2018 13:25:33 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180213122533.GD5083@localhost.localdomain>
References: <cover.1517840876.git.berto@igalia.com>
	<78bcc54bc632574dd0b900a77a00a1b6ffc359e6.1517840877.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78bcc54bc632574dd0b900a77a00a1b6ffc359e6.1517840877.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH v4 34/39] qcow2: Rename l2_table in
 count_contiguous_clusters_unallocated()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

Am 05.02.2018 um 15:33 hat Alberto Garcia geschrieben:
> This function doesn't need any changes to support L2 slices, but since
> it's now dealing with slices intead of full tables, the l2_table

s/intead/instead/

> variable is renamed for clarity.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Kevin
