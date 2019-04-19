Received: from eggs.gnu.org ([209.51.188.92]:60096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHMp0-0007EG-N6
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHMoz-0005lS-Qv
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:16:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hHMoz-0005l6-LM
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:16:25 -0400
Date: Fri, 19 Apr 2019 03:16:23 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190419061623.GR25134@habkost.net>
References: <20190419061349.17094-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419061349.17094-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/17] Delete 16 *_cpu_class_by_name()
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>

Please ignore this series.  I used master as base instead of
machine-next by mistake and it included all the patches that were
already in machine-next.  I'm sending another series with just
the 7 patches that I intended to submit.

-- 
Eduardo
