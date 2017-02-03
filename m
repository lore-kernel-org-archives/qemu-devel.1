Received: from eggs.gnu.org ([2001:4830:134:3::10]:55435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cZcs8-0001OM-Ql
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:21:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cZcs3-0000kT-U2
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:21:48 -0500
Received: from smtp3.mundo-r.com ([212.51.32.191]:44884 helo=smtp4.mundo-r.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cZcs3-0000ia-HU
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:21:43 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1486123043-26493-2-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1486123043-26493-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1486123043-26493-2-git-send-email-pradeep.jagadeesh@huawei.com>
Date: Fri, 03 Feb 2017 13:21:40 +0100
Message-ID: <w51lgtnwjl7.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2 v16] fsdev: add IO throttle support to
 fsdev devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org

On Fri 03 Feb 2017 12:57:22 PM CET, Pradeep Jagadeesh wrote:

> This patchset adds the throttle support for the 9p-local driver.  For
> now this functionality can be enabled only through qemu cli options.
> QMP interface and support to other drivers need further extensions.
> To make it simple for other 9p drivers, the throttle code has been put
> in separate files.
>
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
