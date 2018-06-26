Received: from eggs.gnu.org ([2001:4830:134:3::10]:36302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fXmPf-0001Rp-Ql
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 07:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fXmPf-0000ur-02
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 07:45:35 -0400
References: <20180626084300.12571-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <085e2889-bec5-b368-61b5-06a5f82fc502@redhat.com>
Date: Tue, 26 Jun 2018 06:45:28 -0500
MIME-Version: 1.0
In-Reply-To: <20180626084300.12571-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qapi/job: The next release will be 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

On 06/26/2018 03:43 AM, Kevin Wolf wrote:
> Commit 51f63ec7d tried to change all references to 2.13 into 3.0, but
> it failed to achieve this because it was not properly rebased on top of
> the series introducing qapi/job.json. Change the references now.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   qapi/job.json | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
