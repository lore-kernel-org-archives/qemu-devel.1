Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25605C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:28:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA082085B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA082085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX8Ad-0004cO-8u
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 15:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kX89g-00039d-LH; Mon, 26 Oct 2020 15:27:44 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:42259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kX89a-000169-K1; Mon, 26 Oct 2020 15:27:42 -0400
Received: from [192.168.100.1] ([82.252.139.38]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mzhax-1kB51I1ko5-00vf9i; Mon, 26 Oct 2020 20:27:25 +0100
Subject: Re: [PATCH 2/30] io: Fix Lesser GPL version number
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Chetan Pant <chetan4windows@gmail.com>
References: <20201014134033.14095-1-chetan4windows@gmail.com>
 <20201019104107.GF236912@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <020bfca2-5542-97f4-5315-5e05c4f97dbc@vivier.eu>
Date: Mon, 26 Oct 2020 20:27:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201019104107.GF236912@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uh0a98ym8GIz937OT9xvn9ahSzY1RNqENdtvGyopaI2JlrZieNC
 2R8c6WgSALqS0H1/nkEgK8vf0JYaxblDTYqArKog2CrJOqmbGznOYSwdWIJCCtKWhsnGnh7
 eK4EWd6fHOgusRNqpSuXSRJFmyB4MKb+D1cWrH+45fQaYOGI2ysbiFQK+MCdjNrRtpGraR+
 PXhLBOshPEpfJkqrkd4Fw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QoYObQsk95E=:HeZ8HNV84pcefAiL55pQNu
 ugV2Lo7DsgBi1rXjxbT4h8QbnPsikVIkty7cv2ouAEdf9nviG0vv2HALU8WWeAQRQDbVn7GKC
 j7RC1iqpoz9jga/AmsjllbrE8CNmemZJFX6eTft0KmW1v7PwMcA5qKF0cYMrCBHDfF/9aP6cT
 Dj07K2KDbELYtPPztHw6YVNiYHZ4YA4U3XqrMY5U11bxseWgYhGAg2AzQ3B+uEfu8pl9319ix
 VDc+Tv/f15IN6Zn4KfEqui2F+Tqx2iaEI+H5tBZaalqPfg/56pKXh0bvzIM1jDvUFvUZbEuPK
 GkZWxBS62r/2qiicn1C1LYi0/cVtuQY1FRnBkZT1MznrRcLsbK/D/g1mvweO+xuH+70Lw6NM/
 4A6F1hiIOlMlJYY+ZWUQjZuxKwr25GUn2IkI+xHYKxrtU2MNhYBCWC9emGCRPQ0cyUYktLB2F
 HrmCUBPe9Q==
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 15:27:32
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 19/10/2020 à 12:41, Daniel P. Berrangé a écrit :
> On Wed, Oct 14, 2020 at 01:40:33PM +0000, Chetan Pant wrote:
>> There is no "version 2" of the "Lesser" General Public License.
>> It is either "GPL version 2.0" or "Lesser GPL version 2.1".
>> This patch replaces all occurrences of "Lesser GPL version 2" with
>> "Lesser GPL version 2.1" in comment section.
>>
>> Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
>> ---
>>  include/io/channel-buffer.h     | 2 +-
>>  include/io/channel-command.h    | 2 +-
>>  include/io/channel-file.h       | 2 +-
>>  include/io/channel-socket.h     | 2 +-
>>  include/io/channel-tls.h        | 2 +-
>>  include/io/channel-util.h       | 2 +-
>>  include/io/channel-watch.h      | 2 +-
>>  include/io/channel-websock.h    | 2 +-
>>  include/io/channel.h            | 2 +-
>>  include/io/dns-resolver.h       | 2 +-
>>  include/io/task.h               | 2 +-
>>  io/channel-buffer.c             | 2 +-
>>  io/channel-command.c            | 2 +-
>>  io/channel-file.c               | 2 +-
>>  io/channel-socket.c             | 2 +-
>>  io/channel-tls.c                | 2 +-
>>  io/channel-util.c               | 2 +-
>>  io/channel-watch.c              | 2 +-
>>  io/channel-websock.c            | 2 +-
>>  io/channel.c                    | 2 +-
>>  io/dns-resolver.c               | 2 +-
>>  io/task.c                       | 2 +-
>>  tests/test-io-channel-buffer.c  | 2 +-
>>  tests/test-io-channel-command.c | 2 +-
>>  tests/test-io-channel-file.c    | 2 +-
>>  tests/test-io-channel-socket.c  | 2 +-
>>  tests/test-io-task.c            | 2 +-
>>  27 files changed, 27 insertions(+), 27 deletions(-)
> 
> Acked-by: Daniel P. Berrangé <berrange@redhat.com>

Applied to my trivial-patches branch.

Thanks,
Laurent



