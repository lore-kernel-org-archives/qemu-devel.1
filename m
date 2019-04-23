Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4640AC10F11
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 03:13:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 113DB2075A
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 03:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 113DB2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47310 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIlsY-0007lg-9l
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 23:13:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1hIlrk-0007RK-Dq
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 23:13:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1hIlri-0000OB-Fc
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 23:13:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2204 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wangjie88@huawei.com>)
	id 1hIlre-0000KX-8N; Mon, 22 Apr 2019 23:12:58 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
	by Forcepoint Email with ESMTP id 3DE31D3EF33DFD915B6;
	Tue, 23 Apr 2019 11:12:50 +0800 (CST)
Received: from [127.0.0.1] (10.177.25.93) by DGGEMS404-HUB.china.huawei.com
	(10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 23 Apr 2019
	11:12:41 +0800
To: <qemu-devel@nongnu.org>, <qemu-block@nongnu.org>
From: Jie Wang <wangjie88@huawei.com>
Message-ID: <c47aea74-cec7-0369-591e-e1b1fdddc3e6@huawei.com>
Date: Tue, 23 Apr 2019 11:12:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Originating-IP: [10.177.25.93]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.190
Subject: [Qemu-devel] =?utf-8?q?question=EF=BC=9A_Does_qemu-pr-helper_have?=
 =?utf-8?q?_its_own_log_files=EF=BC=9F?=
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
Cc: "Zhangbo \(Oscar\)" <oscar.zhangbo@huawei.com>,
	"Fangyi \(C\)" <eric.fangyi@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423031240.oXOccF7HBLpLBLfafDtBQTlHtDfsDZsZpIkVTZxPXbI@z>

=C2=A0Does qemu-pr-helper have its own log files=EF=BC=9F










