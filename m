Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8331EC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:35:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1EEC2085B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1EEC2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX8Gx-0004ED-SU
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 15:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kX8AH-0004IV-6B; Mon, 26 Oct 2020 15:28:21 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:55031)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kX8AF-0001DO-Fu; Mon, 26 Oct 2020 15:28:20 -0400
Received: from [192.168.100.1] ([82.252.139.38]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N6bwO-1kKgKR1t0g-01821P; Mon, 26 Oct 2020 20:28:05 +0100
Subject: Re: [PATCH 1/30] cryptodev: Fix Lesser GPL version number
To: Thomas Huth <thuth@redhat.com>, Chetan Pant <chetan4windows@gmail.com>,
 qemu-trivial@nongnu.org
References: <20201014133722.14041-1-chetan4windows@gmail.com>
 <0050fa57-f728-4341-82c0-03ab057e0f7f@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <d6ee885f-b37d-7b1b-5731-bf80facbbe76@vivier.eu>
Date: Mon, 26 Oct 2020 20:28:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <0050fa57-f728-4341-82c0-03ab057e0f7f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:P4X7m7+l0GCgFvAiYOJx602ZFqgYAJenAOZ8Obi+Ub8+qWjN9An
 cmxU1JMXU0wPBk8GolNbYhbaNjVbLNEVTQY3MgosAVFMcMR2rnJaWtkZ854iltsDG9Nbzlz
 6uXbhSIxYlKIz4X6aKLCbqG7ya0CgoRgLnbGAUPniG7gncKOi+N4sw22QJOJhd6IGhZv5Db
 x10Dxy9dIu/3IKW6S0kqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jNDhhTmI/Rw=:e9HBNOXMxL9WFEtZ7o/pnh
 Il+HNFnhWeECvfaeFuaoaNNL7tcLOXsh0AvYvSDo3tQYzvoe8XOSwsL4Pb+olfrXkfgJVN7EZ
 yrQgJqVxVx6l7FF+B8ODfDhvIk2UBcC6wZW0OW1YDYYNgWk77Iyd0vhOJ40FBBj9P/JRm3iVu
 +OEHqSpNihHHh4fpjMcL35bAVyydw8CdAMaI+uKadwv5JNPXIFCKuS5iDNofbrPzanUMVGu0b
 dWGkvzI/mwBmFZqO4DFaaTN+QZwufv/qOUorY/4JcnwAQ47IY2Bt9BccCch6Km4nhBQOvl/22
 3zUWTygweNl5VFur6glxqOnjPrFECCKvsefTymOGC+yygp3pkc5IFEz/hCSsYkK6EMLf+SQsm
 v/XDLelhoHJft2VpLCt5W2p4n1NMVXeHjDy/9EJex5bLFZ85LMG5beU03e/w4oapAjbAF1Dnm
 Es9M58/FHA==
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 15:11:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.167,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 19/10/2020 à 16:49, Thomas Huth a écrit :
> On 14/10/2020 15.37, Chetan Pant wrote:
>> There is no "version 2" of the "Lesser" General Public License.
>> It is either "GPL version 2.0" or "Lesser GPL version 2.1".
>> This patch replaces all occurrences of "Lesser GPL version 2" with
>> "Lesser GPL version 2.1" in comment section.
>>
>> Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
>> ---
>>  backends/cryptodev-builtin.c          | 2 +-
>>  backends/cryptodev-vhost-user.c       | 2 +-
>>  backends/cryptodev-vhost.c            | 2 +-
>>  backends/cryptodev.c                  | 2 +-
>>  include/sysemu/cryptodev-vhost-user.h | 2 +-
>>  include/sysemu/cryptodev-vhost.h      | 2 +-
>>  include/sysemu/cryptodev.h            | 2 +-
>>  7 files changed, 7 insertions(+), 7 deletions(-)
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


