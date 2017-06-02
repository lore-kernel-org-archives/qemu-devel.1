Received: from eggs.gnu.org ([2001:4830:134:3::10]:56850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dGnfP-0004DE-Lm
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dGnfK-0003GK-Ma
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:35:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dGnfK-0003CY-HX
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:35:02 -0400
References: <20170531220129.27724-1-aurelien@aurel32.net>
	<20170531220129.27724-31-aurelien@aurel32.net>
	<ea25b082-923d-6c7d-bca3-b4adbd412419@redhat.com>
	<781667e0-740c-8e43-d94b-387092eab0e6@redhat.com>
	<20170601191718.6cftzl5ama4s3es3@aurel32.net>
	<c3c65598-59ca-c80e-1f8d-340ab19d902f@redhat.com>
	<207db011-5035-acb3-2032-8408b4ec38e6@redhat.com>
	<20170602140429.elahcu5olntw7ypi@aurel32.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <503b3cb8-4867-62a3-85c8-21a0e6adf88f@redhat.com>
Date: Fri, 2 Jun 2017 16:34:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170602140429.elahcu5olntw7ypi@aurel32.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 30/30] target/s390x: update maximum TCG
 model to z800
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 02.06.2017 16:04, Aurelien Jarno wrote:
[...]
> I understand your point. That said I doubt we will support the SIE
> instruction soon (it looks quite complicated and I can't find any doc).

There is unfortunately no public documentation for the SIE instruction.
The only spec that is available is a very old one from the S/370 age:

http://bitsavers.trailing-edge.com/pdf/ibm/370/princOps/SA22-7095-0_370-XA_Interpretive_Execution_Jan84.pdf

 Thomas
