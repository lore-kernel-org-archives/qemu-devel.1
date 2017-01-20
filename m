Received: from eggs.gnu.org ([2001:4830:134:3::10]:46851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cUgKM-0000OF-8V
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 16:02:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cUgKI-0004RT-GE
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 16:02:30 -0500
Date: Fri, 20 Jan 2017 19:02:20 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170120210220.GA21555@thinpad.lan.raisama.net>
References: <1484917276-7107-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484917276-7107-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] Introduce DEVICE_CATEGORY_CPU for CPU
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>

On Fri, Jan 20, 2017 at 02:01:16PM +0100, Thomas Huth wrote:
> Now that CPUs show up in the help text of "-device ?",
> we should group them into an appropriate category.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

I assume Paolo will want to queue it, as he had queued v1.

-- 
Eduardo
