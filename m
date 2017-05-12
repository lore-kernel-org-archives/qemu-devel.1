Received: from eggs.gnu.org ([2001:4830:134:3::10]:44368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d967G-0004Tt-Os
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:40:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d967D-0000nt-Ky
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:40:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1d967D-0000nH-FO
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:39:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 774B37AE83
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 08:39:58 +0000 (UTC)
Date: Fri, 12 May 2017 10:39:56 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170512103956.599bacfe@nial.brq.redhat.com>
In-Reply-To: <20170508183205.10884-1-ehabkost@redhat.com>
References: <20170508183205.10884-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] tests: Add [+-]feature and
 feature=on|off test cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon,  8 May 2017 15:32:05 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> Add test code to ensure features are enabled/disabled correctly in the
> command-line. The test case use the "feature-words" and
> "filtered-features" properties to check if the features were
> enabled/disabled correctly.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

[...]
