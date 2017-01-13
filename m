Received: from eggs.gnu.org ([2001:4830:134:3::10]:52517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cS2Xz-0003v2-T1
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:09:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cS2Xw-00043E-Lu
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:09:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cS2Xw-000438-H0
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:09:36 -0500
Date: Fri, 13 Jan 2017 12:09:32 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170113140932.GT3565@thinpad.lan.raisama.net>
References: <1484272411-28073-1-git-send-email-he.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484272411-28073-1-git-send-email-he.chen@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v2] x86: add AVX512_VPOPCNTDQ features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: He Chen <he.chen@linux.intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, He Chen <he.chen@intel.com>

On Fri, Jan 13, 2017 at 09:53:31AM +0800, He Chen wrote:
> AVX512_VPOPCNTDQ: Vector POPCNT instructions for word and qwords.
> variable precision.
> 
> Signed-off-by: He Chen <he.chen@linux.intel.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Applied to x86-next. Thanks!

-- 
Eduardo
