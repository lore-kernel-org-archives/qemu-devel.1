Received: from eggs.gnu.org ([209.51.188.92]:60184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gvn9U-0006qy-FP
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:56:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gvn9T-0004bL-Ro
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:56:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gvn9T-0004ad-IW
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:56:23 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F4EE81F31
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 17:56:22 +0000 (UTC)
References: <20190212193855.13223-1-ccarrara@redhat.com>
	<20190212193855.13223-3-ccarrara@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <0624c3b5-aee7-8658-cf89-b4ae9f6eeb20@redhat.com>
Date: Mon, 18 Feb 2019 12:56:21 -0500
MIME-Version: 1.0
In-Reply-To: <20190212193855.13223-3-ccarrara@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] tests.acceptance: adds simple
 migration test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Caio Carrara <ccarrara@redhat.com>, qemu-devel@nongnu.org



On 2/12/19 2:38 PM, Caio Carrara wrote:
> This change adds the simplest possible migration test. Beyond the test
> purpose itself it's also useful to exercise the multi virtual machines
> capabilities from base avocado qemu test class.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> Signed-off-by: Caio Carrara <ccarrara@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>
