Received: from eggs.gnu.org ([2001:4830:134:3::10]:45902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJgEy-0004vu-JE
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:20:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJgEx-0005c0-5h
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:20:16 -0400
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b1d0a3e8-32f5-7d7b-b0b6-95e0c3eb7068@redhat.com>
Date: Fri, 18 May 2018 09:20:04 -0500
MIME-Version: 1.0
In-Reply-To: <20180518132114.4070-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/40] blockjob: Update
 block-job-pause/resume documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, jcody@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

On 05/18/2018 08:20 AM, Kevin Wolf wrote:
> Commit 0ec4dfb8d changed block-job_pause/resume so that they return an
> error if they don't do anything because the job is already
> paused/running. It forgot to update the documentation, so do that now.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   qapi/block-core.json | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
