Received: from eggs.gnu.org ([2001:4830:134:3::10]:38222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dS0a9-00061h-Rm
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dS0a4-00052O-VO
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:36:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dS0a4-00051W-P4
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:35:56 -0400
References: <1499076743-15477-1-git-send-email-yang.zhong@intel.com>
	<1499076743-15477-4-git-send-email-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5704a263-0f0c-205f-69e1-995ef2c8bbe1@redhat.com>
Date: Mon, 3 Jul 2017 14:35:52 +0200
MIME-Version: 1.0
In-Reply-To: <1499076743-15477-4-git-send-email-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/15] tcg: tcg_handle_interrupt()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, pbonzini@redhat.com, rth@twiddle.net
Cc: anthony.xu@intel.com, qemu-devel@nongnu.org, a.rigo@virtualopensystems.com

On 03.07.2017 12:12, Yang Zhong wrote:
> Move tcg_handle_interrupt() from translate-common.c to
> accel/tcg/tcg-all.c.

Why is this necessary / wanted? Could you please mention the reason in
the patch description?

 Thanks,
  Thomas
