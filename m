Received: from eggs.gnu.org ([2001:4830:134:3::10]:54799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eMp2F-0007pf-QI
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 00:47:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eMp2F-0006XM-36
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 00:47:51 -0500
References: <1512457825-3847-1-git-send-email-thuth@redhat.com>
	<ee0ee3e4-f8d4-048f-b772-49d15ada4254@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2b2dd271-451c-04cb-044e-ee5b8619559e@redhat.com>
Date: Thu, 7 Dec 2017 06:47:40 +0100
MIME-Version: 1.0
In-Reply-To: <ee0ee3e4-f8d4-048f-b772-49d15ada4254@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/ide: Remove duplicated definitions
 from ahci_internal.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, qemu-block@nongnu.org

On 06.12.2017 23:16, John Snow wrote:
> I tweaked this again, sorry:
> 
> The names need to stay public, but the wrappers to manipulate the
> objects can stay internal. Minor difference.
> 
> If that's okay, I'll just merge this in.
> OK?

Sure. Feel also free to replace my "Signed-off-by" with "Reported-by" in
that case if you like.

 Thomas
