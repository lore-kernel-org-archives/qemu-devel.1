Received: from eggs.gnu.org ([209.51.188.92]:42486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gowD2-0001LF-Vd
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 15:11:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gowD1-000483-2U
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 15:11:44 -0500
References: <20190130152434.17283-1-mreitz@redhat.com>
	<20190130152434.17283-10-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <730e023f-7e04-1b9d-9e19-6e0098eeb8ef@redhat.com>
Date: Wed, 30 Jan 2019 15:11:25 -0500
MIME-Version: 1.0
In-Reply-To: <20190130152434.17283-10-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 09/10] iotests: Let 045 be run
 concurrently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org



On 1/30/19 10:24 AM, Max Reitz wrote:
> Adding a telnet monitor for no real purpose on a fixed port is not so
> great.  Just use a null monitor instead.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Good change.

Reviewed-by: John Snow <jsnow@redhat.com>
