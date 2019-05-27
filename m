Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF93C07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 09:36:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C51562173B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 09:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51562173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42656 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVC3U-0006mG-0W
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 05:36:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1hVC1W-0005Uk-VY
	for qemu-devel@nongnu.org; Mon, 27 May 2019 05:34:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1hVC1W-0004iu-1i
	for qemu-devel@nongnu.org; Mon, 27 May 2019 05:34:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:3654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yu.ning@linux.intel.com>)
	id 1hVC1V-0004fj-R9
	for qemu-devel@nongnu.org; Mon, 27 May 2019 05:34:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	27 May 2019 02:34:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,518,1549958400"; d="scan'208";a="178810922"
Received: from yuning-mobl1.ccr.corp.intel.com (HELO [10.254.212.67])
	([10.254.212.67])
	by fmsmga002.fm.intel.com with ESMTP; 27 May 2019 02:34:25 -0700
To: qemu-devel <qemu-devel@nongnu.org>
From: Yu Ning <yu.ning@linux.intel.com>
Message-ID: <a84315e7-6e37-cb4b-1ec8-f1e5831594e8@linux.intel.com>
Date: Mon, 27 May 2019 17:34:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.65
Subject: [Qemu-devel] New HAXM maintainer
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: haxm-team@intel.com, colin.xu@intel.com, hang.yuan@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

I am leaving Intel, and will soon lose access to my Intel email 
accounts. Effective today, I am no longer maintainer of the HAXM open 
source project (https://github.com/intel/haxm). Colin Xu (colin DOT xu 
AT intel DOT com) will take my place, and he will be helped by Henry 
Yuan (hang DOT yuan AT intel DOT com) as well as the rest of the HAXM 
team at Intel (team email: haxm DASH team AT intel DOT com).

I am grateful for all the support this community has given to HAXM and 
myself over the past few years. I would appreciate your continued 
support for the project and the Intel HAXM team.

Thanks,
Yu

