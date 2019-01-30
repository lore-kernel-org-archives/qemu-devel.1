Received: from eggs.gnu.org ([209.51.188.92]:48211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1goyzS-0008PG-V0
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 18:09:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1goyzS-0002qA-EI
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 18:09:54 -0500
References: <20190130152434.17283-1-mreitz@redhat.com>
	<20190130152434.17283-11-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <f9bb6227-9272-c6a3-4aef-0630560d51ca@redhat.com>
Date: Wed, 30 Jan 2019 18:09:50 -0500
MIME-Version: 1.0
In-Reply-To: <20190130152434.17283-11-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/10] iotests.py: s/_/-/g on keys in
 qmp_log()
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
> This follows what qmp() does, so the output will correspond to the
> actual QMP command.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

Thank you!
