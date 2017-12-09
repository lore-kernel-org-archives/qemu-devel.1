Received: from eggs.gnu.org ([2001:4830:134:3::10]:38053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eNTcG-0004YD-IB
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 20:07:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eNTcF-0007fe-LO
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 20:07:44 -0500
References: <20171123020832.8165-1-mreitz@redhat.com>
	<20171123020832.8165-14-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a51ccafc-eb8c-890a-e483-3375f57647bf@redhat.com>
Date: Fri, 8 Dec 2017 20:07:33 -0500
MIME-Version: 1.0
In-Reply-To: <20171123020832.8165-14-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/17] iotests: Fix 067 for compat=0.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org



On 11/22/2017 09:08 PM, Max Reitz wrote:
> 067 works very well with compat=0.10 once you remove format-specific
> information from the QMP output.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>
