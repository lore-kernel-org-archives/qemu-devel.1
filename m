Received: from eggs.gnu.org ([2001:4830:134:3::10]:56236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp4Cd-0004WF-CY
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp4CY-0002da-VV
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:07:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dp4CY-0002cu-O9
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:06:58 -0400
Date: Tue, 5 Sep 2017 11:06:53 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170905030653.GK22515@lemon.lan>
References: <20170901112829.2571-1-apahim@redhat.com>
	<20170901112829.2571-9-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170901112829.2571-9-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 08/13] qemu.py: refactor launch()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, berrange@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, crosa@redhat.com, ldoktor@redhat.com

On Fri, 09/01 13:28, Amador Pahim wrote:
> This is just an refactor to separate the exception handler from the
> actual launch procedure, improving the readability and making future
> maintenances in this piece of code easier.
> 
> Signed-off-by: Amador Pahim <apahim@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
