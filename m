Received: from eggs.gnu.org ([209.51.188.92]:36353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gn5Q8-0004fP-R0
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 12:37:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gn5MR-0007fE-6b
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 12:33:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gn5MQ-0007f3-Ue
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 12:33:47 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-25-git-send-email-pbonzini@redhat.com>
	<d9bb4dd8-e256-25cd-af38-92d70f71d237@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <47b000c4-c974-fae4-0541-22be46cf96ff@redhat.com>
Date: Fri, 25 Jan 2019 18:33:38 +0100
MIME-Version: 1.0
In-Reply-To: <d9bb4dd8-e256-25cd-af38-92d70f71d237@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 24/52] hw/openrisc/Makefile.objs: Create
 CONFIG_* for openrisc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, Jia Liu <proljc@gmail.com>

On 25/01/19 16:35, Thomas Huth wrote:
> <bikeshedding>
> CONFIG_OR1K_SIM instead of CONFIG_OPENRISC ?
> </bikeshedding>

Sure, I just missed those two remarks.

Paolo
