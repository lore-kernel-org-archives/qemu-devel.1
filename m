Received: from eggs.gnu.org ([2001:4830:134:3::10]:59591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1edzFF-00089J-04
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:08:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1edzF9-0000fK-5A
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:08:12 -0500
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
	<1516694904-64879-19-git-send-email-imammedo@redhat.com>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <e272de4d-94c6-e164-0364-f54402695846@mail.uni-paderborn.de>
Date: Tue, 23 Jan 2018 15:05:05 +0100
MIME-Version: 1.0
In-Reply-To: <1516694904-64879-19-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 18/25] tricore: cpu: add
 CPU_RESOLVING_TYPE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

On 01/23/2018 09:08 AM, Igor Mammedov wrote:
> it will be used for providing to cpu name resolving class for
> parsing cpu model for system and user emulation code.
> 
> Along with change add target to null-machine test, so
> that when switch to CPU_RESOLVING_TYPE happens,
> test would ensure that null-mchine usecase still works.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian
