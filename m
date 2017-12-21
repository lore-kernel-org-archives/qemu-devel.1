Received: from eggs.gnu.org ([2001:4830:134:3::10]:35140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eS9pX-0005jW-CS
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 18:00:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eS9pW-0008Jh-5r
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 18:00:47 -0500
References: <151389701772.99.13078696286436717322@5adcb62bf0d6>
From: John Snow <jsnow@redhat.com>
Message-ID: <ff58eb94-fc46-0571-6d36-83a2bd7a4689@redhat.com>
Date: Thu, 21 Dec 2017 18:00:30 -0500
MIME-Version: 1.0
In-Reply-To: <151389701772.99.13078696286436717322@5adcb62bf0d6>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] file-posix: refuse to open directories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, dgilbert@redhat.com



On 12/21/2017 05:56 PM, no-reply@patchew.org wrote:
> /tmp/qemu-test/src/hw/i386/vmport.c: In function 'vmport_ioport_read':
> /tmp/qemu-test/src/hw/i386/vmport.c:81:9: error: implicit declaration of function 'qemu_log_mask' [-Werror=implicit-function-declaration]
>          qemu_log_mask(LOG_UNIMP, "vmport: unknown command %x\n", command);
>          ^~~~~~~~~~~~~
> /tmp/qemu-test/src/hw/i386/vmport.c:81:9: error: nested extern declaration of 'qemu_log_mask' [-Werror=nested-externs]
> /tmp/qemu-test/src/hw/i386/vmport.c:81:23: error: 'LOG_UNIMP' undeclared (first use in this function)
>          qemu_log_mask(LOG_UNIMP, "vmport: unknown command %x\n", command);
>                        ^~~~~~~~~

fake news
