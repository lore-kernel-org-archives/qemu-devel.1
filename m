Received: from eggs.gnu.org ([2001:4830:134:3::10]:36250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dsyqI-0003Hc-Py
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 18:12:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dsyqG-00024m-Ik
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 18:12:10 -0400
References: <cover.1501827395.git.maozy.fnst@cn.fujitsu.com>
	<cd39d290c76646052e220e4815dc88e1afb6e982.1501827395.git.maozy.fnst@cn.fujitsu.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ff84bff4-6e6e-bb6f-2672-3d73eb531253@redhat.com>
Date: Fri, 15 Sep 2017 18:12:01 -0400
MIME-Version: 1.0
In-Reply-To: <cd39d290c76646052e220e4815dc88e1afb6e982.1501827395.git.maozy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/6] hw/block/fdc: Convert to realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>



On 08/04/2017 06:26 AM, Mao Zhongyi wrote:
> Convert floppy_drive_init() to realize and rename it to
> floppy_drive_realize().
> 
> Cc: John Snow <jsnow@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> 
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

Similar to the first patch, you need to visit the test output for 172
and update it to match accordingly. Should be a trivial fix.

--js
