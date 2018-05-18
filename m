Received: from eggs.gnu.org ([2001:4830:134:3::10]:34514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fJivZ-0002QU-Ne
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:12:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fJivY-0004VH-SI
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:12:25 -0400
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-2-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <4a685394-e900-47be-8417-3bffdcaaa6b0@redhat.com>
Date: Fri, 18 May 2018 13:12:17 -0400
MIME-Version: 1.0
In-Reply-To: <20180518132114.4070-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-devel@nongnu.org, jcody@redhat.com, armbru@redhat.com, mreitz@redhat.com



On 05/18/2018 09:20 AM, Kevin Wolf wrote:
> Commit 0ec4dfb8d changed block-job_pause/resume so that they return an
> error if they don't do anything because the job is already
> paused/running. It forgot to update the documentation, so do that now.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

D:

Reviewed-by: John Snow <jsnow@redhat.com>
